exports.up = function(knex, Promise) {
    return knex.schema.createTable('statuses', table => {
        table.increments();
        table.string('status')
    });
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('statuses');
};
