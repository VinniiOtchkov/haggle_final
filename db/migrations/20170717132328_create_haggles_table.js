exports.up = function(knex, Promise) {
    return knex.schema.createTable('haggles', table => {
        table.increments();
        table.integer('seller_id').references('id').inTable('users');
        table.integer('buyer_id').references('id').inTable('users');
        table.integer('haggle_price');
        table.integer('item_id').references('id').inTable('items');
        table.integer('status_id').references('id').inTable('statuses').defaultTo(1);
    })
};

exports.down = function(knex, Promise) {
    return knex.schema.dropTable('haggles');
};
