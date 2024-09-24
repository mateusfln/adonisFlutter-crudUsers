'use strict'
const Task = use('App/Models/Task');


class TaskController 
{
    async index({ response }) 
    {
        const tasks = await Task.all();
        return response.json(tasks);
    }
    
    async store({ request, response }) 
    {
      const { user_id, title, description, status, start, end } = request.all();
      const task = await Task.create({ user_id, title, description, status, start, end });
      return response.status(201).json(task);
    }
  
    async show({ params, response }) 
    {
      const task = await Task.find(params.id);
      return response.json(task);
    }
  
    async update({ params, request, response }) 
    {
      const task = await Task.find(params.id);
      task.merge(request.all());
      await task.save();
      return response.json(task);
    }
  
    async destroy({ params, response }) 
    {
      const task = await Task.find(params.id);
      await task.delete();
      return response.status(204).send();
    }
}

module.exports = TaskController
