
exports.up = function(knex, Promise) {
  return knex.schema.createTable('users', table => {
      table.increments();
      table.string('name');
      table.string('email').notNullable();
      table.string('password').notNullable();
      table.integer('location_id').references('id').inTable('locations');
  })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('users');
};
