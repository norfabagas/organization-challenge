class UsersController < ApplicationController

  check_authorization
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :load_organizations, only: [:new, :create, :edit, :update]

  def index
    if current_user.admin?
      @persons = User.where.not(role: 'admin').all
    elsif current_user.account_manager?
      ids = current_user.organization.users.all.pluck(:id)
      ids.delete(current_user.id)
      @persons = User.where(id: ids)
    else
      @persons = User.where(id: current_user.id)
    end
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
    if (current_user.id == params[:id])
      flash[:alert] = "You cannot edit your own role"
      return redirect_to root_path
    end
    @person = User.find(params[:id])
    load_roles(@person.organization)
  end

  def update
    @person = User.find(params[:id])
    load_roles(@person.organization)
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

  def load_roles(organization)
    if organization.users.where(role: 'account_manager').count < 1
      @roles = current_user.can_create_roles
      @roles.unshift(["Select Role", nil])
    else
      @roles = [User::ROLES[2]]
      @roles.unshift(["Select Role", nil])
    end
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
