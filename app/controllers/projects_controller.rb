class ProjectsController < ApplicationController
  require "rubygems"
  require "twitter"

  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new(:user_id => current_user.id)
  end
  
  def create
   @project = Project.new(params[:project])
    
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
  
  def send_question
    @project = current_user.projects.find(params[:id])
    if @project
    	 @tasks = @project.tasks.find(:all)  
    	 tweet = @project.name
    	 @tasks.each do |t|
    	 	 tweet += ' ' + t.name + ' ' + 'http://http://quickquestion.benerino.com/updateQuestionHistory/' + t.project_id.to_s + '/' + t.id.to_s
 	 end
    	 current_user.twitter.update(tweet)   
    end
  end
end
