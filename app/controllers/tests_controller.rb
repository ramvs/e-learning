class TestsController < ApplicationController
	before_filter :find_test , only:[:show, :edit,:update,:destroy]

	def index
		@tests = Test.all
	end

	def show
	end

	def edit
	end

	def new
		@test = Test.new
	end

	def create
		@test = Test.new(test_params)
		if @test.save
			redirect_to @test
		else
			render "new"
		end
	end

	def update
		if @test.update_attributes(test_params)
			redirect_to @test
		else
			render 'new'
		end
	end

	def destroy
		@test.destroy
		redirect_to tests_path
	end


	private

		def find_test
			@test = Test.find(params[:id])
		end

		def test_params
			params.require(:test).permit(:title,:description)
		end
end
