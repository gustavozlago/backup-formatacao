# ==========================================
# ALIASES & ATALHOS PERSONALIZADOS
# ==========================================

# Utilitários Visuais & Diversão
alias Hakai='clear'
alias Matrix='cmatrix'
alias Sensores='sensors'

# Informações do Sistema
# Dica: 'fastfetch' é o substituto moderno do neofetch
alias Informações='neofetch'
alias informacoes='neofetch'

# Velocidade de Conexão
alias Velocidade='speedtest --share'
alias velocidade='speedtest --share'

# Data de Instalação do Sistema
alias Inicio="stat -c %w /etc | cut -d'.' -f1"
alias inicio="stat -c %w /etc | cut -d'.' -f1"

# Limpeza Completa do Histórico do Bash
alias Historico='history -c && history -w'
alias historico='history -c && history -w'

# ==========================================
# FUNÇÕES (Para comandos complexos ou com sudo)
# ==========================================

# Atualização Completa do Sistema
Atualizar() {
    echo "=== Atualizando repositórios e pacotes ==="
    sudo sh -c 'apt-get update && apt-get dist-upgrade -y'
    
    if command -v flatpak &> /dev/null; then
        echo "=== Atualizando Flatpaks ==="
        flatpak update -y
    fi
}
alias atualizar='Atualizar'

# Limpeza do Sistema e Manutenção
Limpar() {
    echo "=== Corrigindo pacotes quebrados ==="
    sudo dpkg --configure -a
    sudo apt-get install -f -y

    echo "=== Limpando pacotes e cache do APT ==="
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y
    sudo apt-get clean -y

    echo "=== Limpando arquivos temporários e lixeira ==="
    sudo rm -rf /var/tmp/*
    rm -rf ~/.local/share/Trash/files/* ~/.local/share/Trash/info/*
    
    echo "=== Limpeza concluída! ==="
}
alias limpar='Limpar'
