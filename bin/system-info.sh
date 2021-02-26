#!/bin/bash

MANUFACTURER=$(sudo dmidecode -s chassis-manufacturer)
echo "manufacturer: $MANUFACTURER"

CHASSIS=$(sudo dmidecode -s chassis-type)
echo "chassis-type: $CHASSIS"

PRODUCT=$(sudo dmidecode -s system-version)
echo "device: $PRODUCT"

MODEL=$(sudo dmidecode -s system-product-name)
echo "model: $MODEL"

