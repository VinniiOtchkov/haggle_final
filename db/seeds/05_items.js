
exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('items').del()
    .then(function () {
      // Inserts seed entries
      return knex('items').insert([
        {name: 'amplifier music', initial_price: 1000, description: 'Like new', img_url: '', seller_id: 1},
        {name: 'tv electronics', initial_price: 100, description: '47 inch 1080p but has burnt out pixels', img_url: '', seller_id: 1},
        {name: 'bass guitar music', initial_price: 3000, description: 'Got it from Eddie Van Halen himself', img_url: '', seller_id: 1},
        {name: 'guitar pick music', initial_price: 1000, description: 'used by Eric Clapton', img_url: '', seller_id: 2},
        {name: '2014 Nissan Altima car', initial_price: 14000, description: 'only 28,000 miles', img_url: '', seller_id: 2},
        {name: '2013 Frontier car', initial_price: 21000, description: 'quad cab, cherry red', img_url: '', seller_id: 3},
        {name: 'Nintendo Wii U electronics', initial_price: 150, description: 'selling to buy the Switch', img_url: '', seller_id: 2},
        {name: 'iMac 27" electronics', initial_price: 1500, description: '32 GB RAM, Intel core i7', img_url: '', seller_id: 3},
        {name: 'Drum set music', initial_price: 300, description: 'son no longer uses them', img_url: '', seller_id: 3},
        {name: 'Drobo 5N electronics', initial_price: 600, description: '4 x 3TB drives included', img_url: '', seller_id: 3},
     ]);
    });
};
