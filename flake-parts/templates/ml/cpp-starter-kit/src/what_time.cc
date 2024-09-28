#include "absl/time/time.h"
#include "absl/time/clock.h"
#include "spdlog/spdlog.h"

int main(int argc, char ** argv) {
  absl::Time time = absl::Now();
  spdlog::info("Currently, the UTC time is {}",
               absl::FormatTime(time, absl::UTCTimeZone()));
  return 0;
}
