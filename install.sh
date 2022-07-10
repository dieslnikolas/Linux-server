# Uncomplicated firewall
if [ -x "$(command -v ufw)" ]; then
  echo " Uncomplicated Firewall is already installed"
else
    echo "Installing Uncomplicated Firewall"
    echo "TIP: You need to correctly set up firewall rules at your server provider before you can use the ufw."

    apt-get install ufw -y
    echo "Installing Uncomplicated Firewall... Done"

    echo "Setting up Uncomplicated Firewall default configuration"
    ufw default deny incoming
    ufw default allow outgoing

    echo "Setting up Uncomplicated Firewall for SSH"
    ufw allow ssh
    echo "Setting up Uncomplicated Firewall for SQL Remote Access"
    ufw allow 1433

    echo "Enabling Uncomplicated Firewall"
    ufw enable
fi

# DOCKER
if [ -x "$(command -v docker)" ]; then
  echo "Docker is already installed"
else
    echo "Installing Docker"
    echo "Removing old versions of docker"
    apt-get remove docker docker-engine docker.io containerd runc

    echo "Installing docker-ce prerequisities"
    apt-get install ca-certificates curl gnupg lsb-release -y

    echo "Installing docker-ce"
    mkdir -p /etc/apt/keyrings
    url -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    systemctl enable docker
    systemctl start docker
    echo "Installing docker-ce... Done"

    echo "Creating docker network"
    docker network create nginx-proxy
    echo "Creating docker network... Done"
fi

# Finished
echo "All done"