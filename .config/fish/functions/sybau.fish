function sybau --description 'fucking pacman -Sybau'
  paru && sudo pacman --config /etc/pacman-cachyos.conf -Sy --needed cachyos-keyring cachyos-v3-mirrorlist cachyos-mirrorlist pacman linux-cachyos linux-cachyos-headers scx-scheds nvidia-580xx-dkms
end
