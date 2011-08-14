class ProjectsController < ApplicationController
  require "rubygems"
  require "twitter"

  def home
    @projects = Project.find(:all, :order => 'created_at desc')  
  end
  
  def index
    @projects = current_user.projects.all
  end
  
  def show
    @project = Project.find(params[:id])
    @histories = @project.histories.find(:all, :select => 'count(*) count, task_id', :group => 'task_id')
  end
  
  def new
    @project = current_user.projects.new
  end
  
  def create
   @project = current_user.projects.new(params[:project])
    
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = current_user.projects.find(params[:id])
  end
  
  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
  
  def send_question
    @project = current_user.projects.find(params[:id])
    if @project
        @tasks = @project.tasks.find(:all) 
        use_twitter = current_user.authentications.find_by_provider('twitter')
        use_facebook = current_user.authentications.find_by_provider('facebook')
        
    	sent_to = '' 
    	
        if use_twitter
          sent_to = 'Twitter'	
    	  tweet = Array.new
    	  tweet.push @project.name
    	
    	  @tasks.each do |t|
    	    tweet.push ' ' + t.name + ' ' + 'http://qq.benerino.com/uqh/' + t.project_id.to_s + '/' + t.id.to_s
 	  end
 	 
 	  tweet.each do |st|
    	    current_user.twitter.update(st)   
   	  end
  	end
  	
        if use_facebook
          sent_to += ' & ' if sent_to != ''	
          sent_to += 'Facebook'	
    	  
    	  face = @project.name
    	
    	  @tasks.each do |t|
    	    face += '<br />' + t.name + ' ' + 'http://qq.benerino.com/uqh/' + t.project_id.to_s + '/' + t.id.to_s
 	  end
 	 
 	  current_user.facebook.feed!(:message => face, :name => @project.name)
  	end
    end
    
    if sent_to != ''
      flash[:notice] = "Question sent to: " + sent_to
    else
      flash[:notice] = "Question did not send. Are you signed in with twitter or facebook?"
    end	    
    redirect_to @project
  end
end
