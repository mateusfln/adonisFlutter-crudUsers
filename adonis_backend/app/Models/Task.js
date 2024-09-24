'use strict'

/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')

class Task extends Model 
{
 /**
   * @method users
   *
   * @return {Object}
   */
  users () {
    return this.hasMany('App/Models/User')
  }
}

module.exports = Task
