class PersonsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_organizations, only: [:new, :create, :edit, :update]
  before_action :load_roles, only: [:new, :create, :edit, :update]

  def index
    @persons = User.where.not(role: 'admin').all
  end

  def new
    @person = User.new
  end

  def create
    @person = User.create(user_params)
    if @person.valid?
      # skip validation 
      @person.skip_confirmation!
      @person.save!
      flash[:notice] = I18n.t('persons.created')
      return redirect_to persons_path
    else
      flash[:errors] = @person.errors
      render :new
    end
  end

  def show
    @person = User.find(params[:id])
  end

  def edit
    @person = User.find(params[:id])
  end

  def update
    @person = User.find(params[:id])
    if @person.update(user_params)
      flash[:notice] = I18n.t('persons.updated')
      return redirect_to persons_path
    else
    flash[:errors] = @person.errors
    render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.configuration.delete
    user.delete
    flash[:alert] = I18n.t('persons.deleted')
    return redirect_to persons_path
  end

  private

  def load_organizations
    @organizations = Organization.all.collect {|o| [o.name, o.id]}
    @organizations.unshift(["Select Organization", nil])
  end

  def load_roles
    @roles = current_user.can_create_roles
    @roles.unshift(["Select Role", nil])
  end

  def user_params
    params.require( :user)
          .permit(  :name,
                    :email,
                    :phone,
                    :avatar,
                    :role,
                    :organization_id,
                    :password,
                    :password_confirmation)
  end

end
