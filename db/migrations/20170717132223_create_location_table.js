
exports.up = function(knex, Promise) {
  return knex.schema.createTable('locations', table => {
    table.increments();
    table.string('city');
    table.integer('state_id').references('id').inTable('states');
  })
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('locations');
};
