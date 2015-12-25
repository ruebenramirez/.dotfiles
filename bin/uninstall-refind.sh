#!/bin/bash

[[ -d /efi/refind ]] && sudo rm -R -f /efi/refind
[[ -d /EFI/refind ]] && sudo rm -R -f /EFI/refind
efivol=$(diskutil list | grep " EFI " | grep -o 'disk.*' | head -n 1)
sudo mount -t msdos /dev/${efivol} /Volumes/ESP
[[ $? != 0 ]] && sudo mount -t hfs /dev/${efivol} /Volumes/ESP
[[ -d /Volumes/ESP/EFI/refind ]] && sudo rm -R -f /Volumes/ESP/EFI/refind
sudo umount /Volumes/ESP
sudo bless --setBoot --mount /
