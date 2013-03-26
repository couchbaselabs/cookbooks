default['packages']['dev'] = {
  'libmozjs' => '3.7a3',
  'libevent2' => '2.0.15'
}

if platform != 'fedora'
then
  default['packages']['dev']['erlang-otp'] = 'R14B03'
end
