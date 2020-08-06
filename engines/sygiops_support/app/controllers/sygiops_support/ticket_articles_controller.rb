require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class TicketArticlesController < ApplicationController

    def attachment
      ticket = Ticket.find_by(id: params[:ticket_id])
      article = Ticket::Article.find(params[:article_id])
      if ticket.id != article.ticket_id
        if ticket.state.state_type.name != 'merged'
          raise Exceptions::NotAuthorized, 'No access, article_id/ticket_id is not matching.'
        end

        ticket = article.ticket
      end

      list = article.attachments || []
      file = Store.find(params[:id])

      disposition = params[:disposition]
      content = file.content
      send_data(
        content,
        filename:    file.filename,
        type:        file.preferences['Content-Type'] || file.preferences['Mime-Type'] || 'application/octet-stream',
        disposition: disposition
      )
    end

    def article_plain
      article = Ticket::Article.find(params[:id])
      access!(article, 'read')

      file = article.as_raw

      return if !file

      send_data(
        file.content,
        filename:    file.filename,
        type:        'message/rfc822',
        disposition: 'inline'
      )
    end

  end
end
