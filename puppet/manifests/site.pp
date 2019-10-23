node default {}

node /^(node(10|11))\.build\.it\.com$/ {
  include role::deb_build_server
}
node /^(node(1237|1023|1239|1240))\.test\.net$/ {
  include role::deb9_test_server
}
node /^(node(7|9|10))\.uat\.com$/ {
  include role::deb_server_updates
}
node 'node.uat1100.pl.tst.net' {
  include role::spark_builder
}
