var express = require('express');
var router = express.Router();
var knex = require('../db/knex');

/* GET all items by location. */
router.post('/', function(req, res, next) {
  knex.raw(`select i.id, i.img_url, i.name, i.description, i.initial_price, i.sold, l.city, l.id location_id, u.name seller_name from items i join users u on i.seller_id = u.id join locations l on u.location_id = l.id
            where location_id = ${req.body.location_id} and sold = false`)
    .then(data => {
      res.send(data.rows);
    })
});

//Search for specific items by location
router.post('/search', function(req, res, next) {

  knex.raw(`select i.id, i.img_url, i.name, i.description, i.initial_price, i.sold, l.city, l.id location_id, u.name seller_name from items i join users u on i.seller_id = u.id join locations l on u.location_id = l.id
            where lower(i.name) like lower('%${req.body.name}%' and sold = false order by city`)
    .then(function(data) {
      res.render('search', {
        items: data.rows
      });
    });
});

/* Get Add Item page */
router.get('/addItem', function(req, res, next) {
  var items = {};
  res.render('addItem');
})

// /* Remove Item. */
router.get('/remove/:id', function(req, res, next) {
  knex('items')
    .update('sold', true)
    .where('id', req.body.id)
    .then(function() {
      res.redirect('/user');
    })
})

// /* Update Single Item. */
router.post('/:id/update', function(req, res, next) {
  knex('items')
    .update(req.body)
    .where('id', req.body.id)
    .then(function(items) {
      res.redirect('/user' + req.user.id)
    })
})
/* Add new Item. */
router.post('/addItem', function(req, res, next) {
  knex('items')
    .insert({
      name: req.body.name,
      initial_price: req.body.initial_price,
      description: req.body.description,
      img_url: req.body.img_url,
      seller_id: req.user.id
    })
    .then(() => {
      res.redirect('/user/');
    });
});

router.get('/edit', function(req, res) {
  knex.raw(`select * from items WHERE id = ${req.params.id}`).then(function(items) {
    res.render('editItem', {
      items: items[0].rows
    });
  });
});

router.post('/edit', function(req, res) {
  knex.raw(`update items
    set
    name = '${req.body.name}',
    initial_price = '${req.body.initial_price}',
    description = '${req.body.description}'
    WHERE id = ${req.params.id}
    `).then(function() {
    knex.raw(`select * from items`).then(function(items) {
      res.redirect('/');
    });
  });
});

/* GET Single Item. */
router.get('/:id', function(req, res, next) {
  knex('items')
    .select()
    .where('id', req.params.id)
    .then(function(items) {
      res.render('itemID', {
        items: items[0]
      })
    })
})




module.exports = router;
