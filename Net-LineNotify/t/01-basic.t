use strict;
use warnings;
use Test::More tests => 2;
use Net::LineNotify;

# アクセストークンを指定してモジュールのオブジェクトを作成
my $line = Net::LineNotify->new(access_token => 'dummy_token');
isa_ok($line, 'Net::LineNotify', 'Object creation');

# メッセージ送信テスト（ダミーのトークンを使うので送信は行われません）
ok(!$line->send_message('Test message'), 'Failed to send message with dummy token');
