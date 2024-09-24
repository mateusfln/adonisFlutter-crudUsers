'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class TasksSchema extends Schema {
  up () {
    this.create('tasks', (table) => {
      table.increments('id')
      table.integer('user_id')
      .notNullable()
      .unsigned()
      .references('users.id')
      .onDelete('CASCADE')
      table.string('title').notNullable()
      table.string('description').notNullable()
      table.boolean('status').notNullable()
      table.date('start').notNullable()
      table.date('end').notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('tasks')
  }
}

module.exports = TasksSchema
