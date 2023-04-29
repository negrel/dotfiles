{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "evolution-with-protonmail-bridge";
  runtimeInputs = with pkgs; [
    bash
    evolution
    protonmail-bridge
  ];
  text = with pkgs; ''
    set -e

    # Define a function to gracefully terminate the child processes
    function graceful_shutdown() {
      echo "Caught SIGINT, terminating child processes..."
      kill -SIGTERM "$child1" "$child2"
      wait "$child1" "$child2"
      exit 0
    }

    # Register the graceful_shutdown function to be called on SIGINT
    trap graceful_shutdown SIGINT

    # Run the first command in the background and save its PID
    ${protonmail-bridge}/bin/protonmail-bridge -n &
    child1=$!

    # Run the second command in the background and save its PID
    ${evolution}/bin/evolution &
    child2=$!

    # Wait for both child processes to exit
    wait "$child1" "$child2"
  '';
}
