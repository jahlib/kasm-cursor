FROM kasmweb/ubuntu-noble-desktop:1.17.0-rolling-weekly
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Update Ubuntu and software.
RUN apt update \
    && sudo apt upgrade -y

RUN apt install -y sudo wget gpg rsync htop mc net-tools locales apt-transport-https curl npm nodejs gnome-keyring && \
    echo "kasm-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/list/* && \
    sudo passwd -d kasm-user && \
    echo 'set -o history' >> $HOME/.bashrc && \
    echo 'shopt -s histappend' >> $HOME/.bashrc && \
    echo 'PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> $HOME/.bashrc && \
    echo 'export HISTSIZE=10000' >> $HOME/.bashrc && \
    echo 'export HISTFILESIZE=10000' >> $HOME/.bashrc && \
    echo 'export HISTCONTROL=ignoredups:erasedups' >> $HOME/.bashrc && \
    echo "export HISTFILE=/home/kasm-user/.bash_history" >> $HOME/.bashrc && \
    echo 'alias ll="ls -lah"' >> $HOME/.bashrc && \
    echo 'if [ -n "$BASH_VERSION" ]; then' >> $HOME/.profile && \
    echo 'if [ -f "/home/kasm-user/.bashrc" ]; then' >> $HOME/.profile && \
    echo '    . /home/kasm-user/.bashrc"' >> $HOME/.profile && \
    echo 'fi fi' >> $HOME/.profile

RUN wget https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/2.0 -O $HOME/cursor.deb && dpkg -i $HOME/cursor.deb
RUN sed -i 's|^Exec=\(.*cursor\)\(.*\)|Exec=\1 --no-sandbox --password-store=basic\2|' /usr/share/applications/cursor.desktop && \
    sed -i 's|^Exec=\(.*cursor\)\(.*\)|Exec=\1 --no-sandbox --password-store=basic\2|' /usr/share/applications/cursor-url-handler.desktop

RUN ln -sf /usr/share/applications/cursor.desktop $HOME/Desktop/cursor.desktop && \
    chmod a+x $HOME/Desktop/cursor.desktop && \
    wget https://images.wallpaperscraft.com/image/single/branch_thuja_needles_144305_3840x2160.jpg -O /usr/share/backgrounds/bg_default.png

RUN locale-gen ru_RU.UTF-8 && \
    update-locale LANG=ru_RU.UTF-8
ENV LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:ru \
    LC_ALL=ru_RU.UTF-8

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
