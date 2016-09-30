#!/usr/bin/env bats

@test "freeradius config is ok" {
  run radiusd -C
  [ "$status" -eq 0 ]
}
