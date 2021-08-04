class Api::V1::HabitsController < ApplicationController

  def index
    habits = Habit.order('created_at DESC')
    render json: {status: 'SUCCESS', message:'Habits Loaded', data: habits}, status: :ok
  end
  
  def show
    habit = Habit.find(params[:id])
    render json: {status: 'SUCCESS', message:'Habits Loaded', data: habit}, status: :ok
  end

  def create
    habit = Habit.new(habit_params)
    if habit.save
      render json: {status:'SUCCESS', message: 'Habit Created', data: habit}
    else
      render json: {status: 'ERROR', message: 'Could not create habit', data:habit.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    habit = Habit.find(params[:id])
    habit.destroy
    render json: {status: 'SUCCESS', message: 'Deleted habit', data: habit}, status: :ok
  end

  def update
    habit = Habit.find(params[:id])
    if habit.update_attributes(habit_params)
      render json: {status: 'SUCCESS', message:'Updated habit', data:habit},status: :ok
    else
      render json: {status: 'ERROR', message:'habits not update', data:habit.erros},status: :unprocessable_entity
    end
  end

  private
  def habit_params
    params.permit(:name)
  end
end
