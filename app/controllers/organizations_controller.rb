class OrganizationsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @organizations = Organization.all
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
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
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
