class LocalityPolicy < ApplicationPolicy
	def index?
		user.present? && (user.role?(:admin))
	end
end