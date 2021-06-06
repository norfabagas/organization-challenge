class OrganizationsController < ApplicationController
 
  check_authorization
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    if current_user.admin?
      @organizations = Organization.all
    else
      @organizations = Organization.where(id: current_user.organization.id)
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.create(organization_params)
    if @organization.valid?
      flash[:notice] = I18n.t('organizations.created')
      return redirect_to organizations_path
    else
      flash[:errors] = @organization.errors
      render :new
    end
  end

  def show
    if current_user.admin?
      @organization = Organization.find(params[:id])
    else
      @organization = current_user.organization
    end
  end

  def edit
    if current_user.admin?
      @organization = Organization.find(params[:id])
    else
      @organization = current_user.organization
    end
  end

  def update
    if current_user.admin?
      @organization = Organization.find(params[:id])
    else
      @organization = current_user.organization
    end

    if @organization.update(organization_params)
      flash[:notice] = I18n.t('organizations.updated')
      return redirect_to organizations_path
    else
      flash[:errors] = @organization.errors
      render :edit
    end
  end

  def destroy
    Organization.delete(params[:id])
    flash[:alert] = I18n.t('organizations.deleted')
    return redirect_to organizations_path
  end

  private

  def organization_params
    params.require( :organization)
          .permit(  :name,
                    :email,
                    :phone,
                    :logo,
                    :website)
  end
end
