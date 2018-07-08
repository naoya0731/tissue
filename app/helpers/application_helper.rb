module ApplicationHelper
  def qrcode_tag(text, options = {})
    ::RQRCode::QRCode.new(text).as_svg(options).html_safe
  end

  def default_meta_tags
    {
      site: 'ティッシュ',
      reverse: true,
      title: 'コンテンツをすぐ共有！',
      description: 'ティッシュはコンテンツをすぐ共有するためのサービスです。',
      keywords: '共有',
      canonical: request.original_url,
      og: {
        title: :title,
        type: :page,
        url: request.original_url,
        #image: image_url(Settings.site.meta.ogp.image_path),
        site_name: 'ティッシュ',
        description: :description,
        locale: 'ja_JP'
      }
    }
  end
end
