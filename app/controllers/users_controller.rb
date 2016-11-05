class UsersController < ApplicationController

  def session_create
    user = User.where(email: params[:email], password: params[:password]).first
    if user
      user.generate_token
      render json: {result: 0, user_id: user.id, token: user.token, message: 'successfully logged in'}
    else
      render json: {result: 1, message: "Invalid email or password"}
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      user.generate_token
      render json: {result: 0, user_id: user.id, token: user.token, message: 'successfully signup'}
    else
      render json: {result: 1, message: "Error while submitting form"}
    end
  end

  def forgot_password
    user = User.find_by_email(params[:email])
    if user
      user.generate_reset_password_token
      render json: {result: 0}
    else
      render json: {result: 1, message: "Invalid email address."}
    end

  end

  def change_password
    user = User.find_by_token(params[:token])
    if user
      user.update_attributes(password: params[:password])
      render json: {result: 0}
    else
      render json: {result: 1, message: "Invalid token."}
    end
  end

  def pending_jobs
    render json: { result: 0, job_id: (1...34).to_a }
  end

  def pending_job_details
    # sleep 0.3
    pay_type = [{type: 'hour_rate', hour_rate: "$#{rand(5...50)}", budget: nil},{ type: 'fixed_rate', budget: "$#{rand(200...10000)}"}].sample

    lasting = [{type: 'Less than 1 week', value: 'less_than_1_week'}, {type: 'Less than 2 weeks', value: 'less_than_2_weeks'}, {type: 'Less than 1 month', value: 'less_than_1_month'}, {type: 'More than 1 month', value: 'more_than_1_month'}].sample

    privacy = [{type: 'Public Job', value: 'public_job'}, {type: 'Private Job', value: 'private_job'}].sample

    category = ['mobile', 'php', 'ruby', 'html5', 'css', 'bootstrap', 'ruby on rails', 'reactjs', 'android', 'ios', 'mobile', 'website', 'server'].sample(rand(1..13)).uniq
    
    data = { result: 0, job_id: params[:id], title: "title #{params[:id]}", post_date: (Date.today - ("#{params[:id]}").to_i.days), description: Faker::Lorem.paragraph(10), pay_type: pay_type[:type], hour_rate: pay_type[:hour_rate], budget: pay_type[:budget], lasting: lasting[:type], privacy: privacy[:type], invited_count: rand(0..10), recommended_count: rand(0..3), proposal_count: rand(0..3), category: category}
    
    render json: data
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :country)
    end
end
