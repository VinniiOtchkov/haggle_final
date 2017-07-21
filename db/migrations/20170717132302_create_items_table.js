exports.up = function(knex, Promise) {
    return knex.schema.createTable('items', table => {
        table.increments();
        table.string('name').notNullable();
        table.integer('initial_price').notNullable();
        table.string('description').notNullable();
        table.boolean('sold').defaultTo(false);
        table.string('img_url');
        table.integer('seller_id').references('id').inTable('users');
    })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('items');
};
