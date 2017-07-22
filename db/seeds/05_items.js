exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('items').del()
    .then(function () {
      // Inserts seed entries
      return knex('items').insert([
        {name: 'amplifier music', initial_price: 1000, description: 'Like new', img_url: 'https://images-na.ssl-images-amazon.com/images/G/01/electronics/detail-page/PTAU45.jpg', seller_id: 1},
        {name: 'tv electronics', initial_price: 100, description: '47 inch 1080p but has burnt out pixels', img_url: 'http://4k.com/wp-content/uploads/2015/12/Samsung-TV-Apps-5@2x.jpg', seller_id: 1},
        {name: 'bass guitar music', initial_price: 3000, description: 'Got it from Eddie Van Halen himself', img_url: 'http://media.guitarcenter.com/is/image/MMGS7/LX200B-Series-III-Electric-Bass-Guitar-Metallic-Blue/H11151000001000-00-500x500.jpg', seller_id: 1},
        {name: 'guitar pick music', initial_price: 1000, description: 'used by Eric Clapton', img_url: 'https://multimedia.bbycastatic.ca/multimedia/products/1500x1500/102/10262/10262918.jpg', seller_id: 2},
        {name: '2014 Nissan Altima car', initial_price: 14000, description: 'only 28,000 miles', img_url: 'https://cars.usnews.com/static/images/Auto/izmo/i4495/2014_nissan_altima_angularfront.jpg', seller_id: 2},
        {name: '2013 Frontier car', initial_price: 21000, description: 'quad cab, cherry red', img_url: 'https://www.cstatic-images.com/car-pictures/xl/CAC30NIT123A021001.png', seller_id: 3},
        {name: 'Nintendo Wii U electronics', initial_price: 150, description: 'selling to buy the Switch', img_url: 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Wii_U_Console_and_Gamepad.png', seller_id: 2},
        {name: 'iMac 27" electronics', initial_price: 1500, description: '32 GB RAM, Intel core i7', img_url: 'https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/I/MA/IMAC/IMAC?wid=1200&hei=630&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=8oel91', seller_id: 3},
        {name: 'Drum set music', initial_price: 300, description: 'son no longer uses them', img_url: 'https://s3.amazonaws.com/images.static.steveweissmusic.com/products/images/uploads/1133742_28255_popup.jpg', seller_id: 3},
        {name: 'Drobo 5N electronics', initial_price: 600, description: '4 x 3TB drives included', img_url: 'http://www.drobo.com/wp-content/uploads/2014/02/5bay-front-header.png', seller_id: 3},
     ]);
    });
};
