exports.up = function(knex, Promise) {
    return knex.schema.createTable('states', table => {
        table.increments();
        table.string('name');
        table.string('abreviation');
    })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('states');
};
