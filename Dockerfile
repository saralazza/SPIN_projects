FROM hamroctopus/spin:6.4.5

# Install pure prompt for zsh for nicer CLI experience
RUN apt-get update -qq && \
    apt-get install -y -qq git wget tree tk x11-apps graphviz ghostscript 
RUN git clone https://github.com/powerline/fonts.git --depth=1 fonts && \
    cd fonts && \
    ./install.sh && \
    cd .. && \
    rm -rf fonts
# Install statically-linked zsh with autocompletions and syntax highlighting
RUN echo "1\ny" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh-bin/master/install)" 
RUN ln -s /usr/local/bin/zsh /bin/zsh
COPY docker_configs/setup_zsh_prompt.sh /root/setup_zsh_prompt.sh
COPY docker_configs/.p10k.zsh /root/.p10k.zsh
RUN chmod +x /root/setup_zsh_prompt.sh && \
    /root/setup_zsh_prompt.sh

# install ispin from other SPIN distribution
RUN wget https://spinroot.com/spin/Archive/spin645.tar.gz && \
    tar xfz spin645.tar.gz && \
    chmod +x /data/Spin/iSpin/install.sh
WORKDIR /data/Spin/iSpin
RUN ./install.sh -q
    
RUN chsh -s $(which zsh)

# clear apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /project

CMD ["/bin/zsh", "-l"]

