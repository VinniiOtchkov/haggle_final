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
router.get('/new', function(req, res, next) {
  var users = {};
  knex('locations')
    .select()
    .then(function(locations) {
      res.render('user_signup', {
        locations
      });
    });
});

/* GET Login Page. */
router.get('/login', function(req, res, next) {
  res.render('user_login');
});

/* GET Login Redirect Page. */
router.get('/login_redirect', function(req, res, next) {
  res.render('user_login_redirect');
});

/* GET USER page. */
router.get('/', function(req, res, next) {
  if (req.isAuthenticated()) {
    console.log('THIS:',req.body);
    Promise.all([knex('seller_item_list')
      .select('users.name', 'users.email', 'statuses.status', 'seller_item_list.*')
      .leftJoin('users', 'seller_item_list.buyer_id', 'users.id')
      .leftJoin('statuses', 'seller_item_list.status_id', 'statuses.id')
      .where('seller_id', req.user.id),

      knex('buyer_by_id')
      .join('users', 'users.id', 'buyer_by_id.buyer_id')
      .select('img_url', 'item_name', 'haggle_price', 'seller_name', 'city', 'status')
      .where('buyer_id', req.user.id),
      knex('users')
      .select('name')
      .where('users.id', req.user.id),
    ]).then(function(users) {
      res.render('user', {
        selling: users[0],
        buying: users[1],
        users: users[2]
      });
    });
  } else {
    res.redirect('/user/login_redirect');
  }
});

/* Deletes User. */
router.get('/:id/remove', function(req, res, next) {
  knex('users')
    .del()
    .where('id', req.params.id)
    .then(function() {
      res.redirect('/');
    });
});

/* logging out User. */
router.get('/logout', function(req, res) {
  req.logout();
  res.redirect('/');
});

/* Creates New User. */
router.post('/new', function(req, res, next) {
  bcrypt.genSalt(10, function(err, salt) {
    bcrypt.hash(req.body.password, salt, function(err, hashedPassword) {

      knex('users')
        .insert({
          name: req.body.name,
          email: req.body.email,
          password: hashedPassword,
          location_id: req.body.location_id
        })
        .then(function() {
          knex('users')
            .select()
            .max('id')
            .then(function() {
              res.redirect('/');
            });
        });
    });
  });
});

/* Updates User */
router.post('/:id/update', function(req, res) {
  knex('users')
    .update(req.body)
    .where('id', req.user.id)
    .then(function(users) {
      res.redirect(`/${req.user.id}`);
    });
});



module.exports = router;
