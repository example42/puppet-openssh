
# include this class where you want the hostkeys without configuring the server
class openssh::hostkeys {
  Sshkey <<| tag == 'openssh::hostkeys' or tag == "openssh::hostkeys::${::domainname}" |>>
}