module Webhookable extend ActiveSupport::Concern
  def set_xml_content_type
    response.headers['Content-Type'] = 'text/xml'
  end

  def render_as_xml( response )
    render :xml => response.to_xml
  end
end