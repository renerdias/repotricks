
## Uso:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

### Comandos comuns:
<table>
  <tr>
    <td>run</td>
    <td>Cria e executa um novo contêiner a partir de uma imagem</td>
  </tr>
  <tr>
    <td>exec</td>
    <td>Executa um comando em um contêiner em execução</td>
  </tr>
  <tr>
    <td>ps</td>
    <td>Lista os contêineres</td>
  </tr>
  <tr>
    <td>build</td>
    <td>Constrói uma imagem a partir de um Dockerfile</td>
  </tr>
  <tr>
    <td>pull</td>
    <td>Download an image from a registry</td>
  </tr>
  <tr>
    <td>push</td>
    <td>Upload an image to a registry</td>
  </tr>
  <tr>
    <td>images</td>
    <td>Lista as imagens</td>
  </tr>
  <tr>
    <td>login</td>
    <td>Log in to a registry</td>
  </tr>
  <tr>
    <td>logout</td>
    <td>Log out from a registry</td>
  </tr>
  <tr>
    <td>search</td>
      <td>Pesquisa por imagens no Docker Hub</td>
  </tr>
  <tr>
    <td>version</td>
    <td>Mostra as informações da versão do Docker</td>
  </tr>
  <tr>
    <td>info</td>
    <td>Exibir informações de todo o sistema</td>
  </tr>
</table>



---
   

Management Commands:
  builder     Manage builds
  checkpoint  Manage checkpoints
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  plugin      Manage plugins
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes
  
---
Swarm Commands:
  config      Manage Swarm configs
  node        Manage Swarm nodes
  secret      Manage Swarm secrets
  service     Manage Swarm services
  stack       Manage Swarm stacks
  swarm       Manage Swarm

---

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Global Options:
      --config string      Location of client config files (default "/home/rener/.docker")
  -c, --context string     Name of the context to use to connect to the daemon (overrides DOCKER_HOST env var
                           and default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket to connect to
  -l, --log-level string   Set the logging level ("debug", "info", "warn", "error", "fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/home/rener/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/home/rener/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/home/rener/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Run 'docker COMMAND --help' for more information on a command.
