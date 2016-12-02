Paperclip::Attachment.default_options[:url] = ':(自分のS3バケット名).(アクセスURL)'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = '(ホスト名)'
