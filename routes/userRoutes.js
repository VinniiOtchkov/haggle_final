var express = require('express');
var router = express.Router();
var knex = require('../db/knex');
const bcrypt = require('bcrypt');

/* checking if Authed */
function checkAuthed(req, res, next) {
  if (req.isAuthenticated()) {
    next();
  } else {
    res.redirect('/login');
  }
}

/* Get new User Page. */
router.get('/new', function (req, res, next) {
  var users = {};
  knex('locations')
    .select()
    .then(function (locations) {
      res.render('user_signup', {
        locations
      });
    });
});

/* GET Login Page. */
router.get('/login', function (req, res, next) {
  res.render('user_login');
});

/* GET Login Redirect Page. */
router.get('/login_redirect', function (req, res, next) {
  res.render('user_login_redirect');
});

/* GET USER page. */
router.get('/', function (req, res, next) {
  if (req.isAuthenticated()) {
    Promise.all([knex.raw(`select u.name, u.email, st.status, s.*
from (select u2.email, h.id haggle_id, h.itemid, h.name item_name, h.seller_id, h.haggle_price, h.buyer_id, h.status_id, h.img_url, u.name seller_name from users u right join (select h.item_id, i.seller_id, h.id, i.name, i.id itemid, i.description, i.img_url, i.initial_price, h.haggle_price, h.buyer_id,
h.status_id from items i left join haggles h on i.id = h.item_id) h on u.id = h.seller_id left join users u2 on h.buyer_id = u2.id) s
left join users u on s.buyer_id = u.id
left Join statuses st on s.status_id = st.id where s.seller_id = ${req.user.id}`),

      knex.raw(`select b.img_url, b.item_name, b.haggle_price, b.seller_name, b.city, b.status
from (select u.name buyer_name, u.id as buyer_id, u2.name seller_name, u2.id seller_id, i.name item_name, i.description, i.img_url, h.haggle_price, s.status, l.city from haggles h join users u on u.id = h.buyer_id join users u2 on u2.id = h.seller_id join items i on h.item_id = i.id join statuses s on h.status_id = s.id join locations l on l.id = u2.location_id) b
join users u on u.id = b.buyer_id where b.buyer_id = ${req.user.id}`),
      knex('users')
      .select('name')
      .where('users.id', req.user.id),
    ]).then(function (users) {
      //console.log(users[0])
      res.render('user', {
        selling: users[0].rows,
        buying: users[1].rows,
        users: users[2]
      });
    });
  } else {
    res.redirect('/user/login_redirect');
  }
});

/* Deletes User. */
router.get('/:id/remove', function (req, res, next) {
  knex('users')
    .del()
    .where('id', req.params.id)
    .then(function () {
      res.redirect('/');
    });
});

/* logging out User. */
router.get('/logout', function (req, res) {
  req.logout();
  res.redirect('/');
});

/* Creates New User. */
router.post('/new', function (req, res, next) {
  bcrypt.genSalt(10, function (err, salt) {
    bcrypt.hash(req.body.password, salt, function (err, hashedPassword) {

      knex('users')
        .insert({
          name: req.body.name,
          email: req.body.email,
          password: hashedPassword,
          location_id: req.body.location_id
        })
        .then(function () {
          knex('users')
            .select()
            .max('id')
            .then(function () {
              res.redirect('/');
            });
        });
    });
  });
});

/* Updates User */
router.post('/:id/update', function (req, res) {
  knex('users')
    .update(req.body)
    .where('id', req.user.id)
    .then(function (users) {
      res.redirect(`/${req.user.id}`)
    });
});



module.exports = router;