
exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('users').del()
    .then(function () {
      // Inserts seed entries
      return knex('users').insert([
        {name: 'Race Carpenter', email: 'racecarpenter@gmail.com', password: '$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu', location_id: 1},
        {name: 'Vinnii Otchkov', email: 'vinniiotchkov@gmail.com', password: '$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu', location_id: 4},
        {name: 'Tom Martin', email: 'tom.martinaz@gmail.com', password: '$2a$10$40brwUHOWWb4Hdxr1bXEjOMwxfiAYIGIVrevoXmk8jRmEOqPp8bbu', location_id: 6},
      ]);
    });
};
