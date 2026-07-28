alias dcu "docker compose up -d"
alias dcs "docker compose stop"
# TODO: make dcsa a function that can accept an optional argument to stop all containers containing a name
#alias dcsa "docker ps --format json | jq .ID | xargs docker stop" # stop all docker containers
function dcsa
	set -l available (docker ps --format 'table {{.Names}}')

	if test -z "$argv[1]"
		# TODO: move this to a function or something (including the available variable)
		if test (string length -- "$available") -eq 5
			echo "No containers are running"
			return
		end

		echo "Stopping all running Docker containers"
		docker ps --format json | jq .ID | xargs docker stop >/dev/null
		return
	end

	set -l containers (docker ps --filter name=^"$argv[1]" --format json | jq .ID)

	if test (string length -- "$containers") -eq 0

		if test (string length -- "$available") -eq 5
			echo "No containers are running"
			return
		end

		echo "No containers running beginning with $argv[1]. Here's a list of available containers:"
		echo "$available"

		return
	end

	echo "Stopping all running containers beginning with $argv[1]"
	docker ps --filter name=^"$argv[1]" --format json | jq .ID | xargs docker stop >/dev/null
end
alias dcr "docker compose restart"
alias dc "docker compose"
alias d "docker"
alias dps "docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}'"
alias dcl "docker compose logs -f"
alias dive "docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
alias trivy-scan "docker run --rm  -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image"
function ngrok-serve
	if test -z "$NGROK_TOKEN"; or test -z "$NGROK_URL"
		echo "Please set NGROK_AUTHTOKEN and NGROK_URL environment variables."
		return 1
	end

	docker run --net=host -it -e NGROK_AUTHTOKEN="$NGROK_TOKEN" ngrok/ngrok http 80 --url="$NGROK_URL"
end
# alias ngrok-serve "docker run --net=host -it -e NGROK_AUTHTOKEN=<REPLACEME> ngrok/ngrok http 80 --url=<REPLACEME>"
