class Message
  module RecentMessages
    extend ActiveSupport::Concern
    included do
      belongs_to :chef
      validates :content, presence: true
      validates :chef_id, presence: true
    end

    class_methods do
      def most_recent
        order(:created_at).last(20)
      end
    end
  end
end
