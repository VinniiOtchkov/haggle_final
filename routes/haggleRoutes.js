var express = require('express');
var router = express.Router();
var knex = require('../db/knex');

router.post('/update', function(req, res, next) {
  knex('haggles')
    .update(req.body)
    .where('id', req.body.id)
    .then(function(data) {
      res.send(data);
    });
});


router.post('/accept',function(req,res,next){
  //console.log('Quote req body for haggle accept:',req.body);
  knex('haggles')
  .update({
    status_id: 2
  })
  .where('id',req.body.haggle_id)
  .then(function(){
    res.redirect('/user');
  });
});


router.post('/reject',function(req,res,next){
  knex('haggles')
  .update({
    status_id: 3
  })
  .where('id',req.body.haggle_id)
  .then(function(){
    res.redirect('/user');
  });
});

router.post('/', function(req, res, next) {
  if (req.isAuthenticated()) {
    knex('haggles')
      .insert({
        seller_id: req.body.seller_id,
        buyer_id: req.user.id,
        haggle_price: req.body.haggle_price,
        item_id: req.body.item_id
      })
      .then(function() {
        res.redirect('/user');
      });
  } else {
    res.redirect('/user/login_redirect');
  }
});



// router.post('/:user_id', function(req, res, next) {
//   knex('haggles')
//     .count()
//     .where('seller_id', req.params.user_id)
//     .then(function(data) {
//       res.send(data);
//     });
// });

module.exports = router;
