package Net::LineNotify;

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common;

our $VERSION = '0.02';

# コンストラクタ
sub new {
    my ($class, %args) = @_;
    my $self = {
        access_token => $args{access_token},  # アクセストークン
    };
    bless $self, $class;
    return $self;
}

# LINE Notifyにメッセージを送信するメソッド
sub send_message {
    my ($self, $message) = @_;
    my $url = 'https://notify-api.line.me/api/notify';

    # UserAgentのセットアップ
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    # POSTリクエストの作成
    my $req = POST(
        $url,
        'Authorization' => "Bearer " . $self->{access_token},  # トークンをヘッダーに追加
        Content_Type    => 'form-data',
        Content         => [ message => $message ],            # メッセージを送信
    );

    # リクエストを送信し、レスポンスを受け取る
    my $response = $ua->request($req);

    # レスポンスのステータスコードを確認
    if ($response->is_success) {
        return 1;  # 成功
    } else {
        # ステータスコードに応じてエラーメッセージを表示
        if ($response->code == 401) {
            warn "エラー: 認証に失敗しました。アクセストークンが無効です。\n";
        } else {
            warn "エラー: " . $response->status_line . "\n";
        }
        return 0;  # 失敗
    }
}

1;  # パッケージの終わりには1を返す必要があります。

__END__

=head1 NAME

Net::LineNotify - LINE Notify API用の簡単なPerlラッパー

=head1 SYNOPSIS

  use Net::LineNotify;

  my $line = Net::LineNotify->new(access_token => 'YOUR_ACCESS_TOKEN');
  $line->send_message('Hello from Perl!');

=head1 DESCRIPTION

C<Net::LineNotify>は、LINE Notify APIを使用してLINEアカウントに通知を送信するためのシンプルなPerlモジュールです。

=head1 METHODS

=head2 new

  my $line = Net::LineNotify->new(access_token => 'YOUR_ACCESS_TOKEN');

新しいC<Net::LineNotify>オブジェクトを作成します。アクセストークンが必要です。

=head2 send_message

  $line->send_message('Your message here');

指定したメッセージをLINEに送信します。送信が成功すれば1を返し、失敗すれば0を返します。

=head1 AUTHOR

Your Name <your.email@example.com>

=head1 LICENSE

このライブラリはフリーソフトウェアです。Perlと同じ条件で再配布および変更が可能です。

