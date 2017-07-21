
exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('locations').del()
    .then(function () {
      // Inserts seed entries
      return knex('locations').insert([
        {city: 'Phoenix', state_id: 3},
        {city: 'Mesa', state_id: 3},
        {city: 'Tempe', state_id: 3},
        {city: 'Glendale', state_id: 3},
        {city: 'Chandler', state_id: 3},
        {city: 'Queen Creek', state_id: 3},
        {city: 'Peoria', state_id: 3},
        {city: 'Gilbert', state_id: 3},
        {city: 'Ahwatukee', state_id: 3},
        {city: 'Laveen', state_id: 3},
      ]);
    });
};
