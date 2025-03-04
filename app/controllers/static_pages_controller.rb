class StaticPagesController < ApplicationController
  def home
    @recommend = Product.with_attached_ref
                        .where.not(active_storage_attachments: { id: nil })
                        .order('RANDOM()')
                        .limit(3)
  end

  def about
  end
end
