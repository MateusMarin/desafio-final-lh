# 📘 ETL Pipeline com Databricks e Terraform

Este repositório contém um pipeline de ELT desenvolvido para extrair, transformar e carregar dados utilizando Databricks e Terraform. A solução é organizada para manter a infraestrutura separada da lógica de processamento de dados.

## 🛠 Configuração do Ambiente

### 🔹 1. Instalação e Configuração do Terraform

Terraform é utilizado para provisionar os catálogos e esquemas no Unity Catalog do Databricks.

#### **Instalação**

Certifique-se de ter o Terraform instalado:

```bash
# Para sistemas baseados em Debian/Ubuntu
sudo apt-get update && sudo apt-get install -y terraform

# Para macOS
brew install terraform

# Para Windows
choco install terraform
```

Verifique a instalação com:

```bash
terraform -version
```

#### **Configuração**

1. Defina as credenciais do Databricks no arquivo `terraform.tfvars`:
   - `databricks_host`: URL do workspace do Databricks.
   - `databricks_token`: Personal Access Token (PAT) do Databricks.
2. Inicialize o Terraform:
   ```bash
   terraform init
   ```
3. Valide a configuração:
   ```bash
   terraform plan
   ```
4. Aplique as configurações:
   ```bash
   terraform apply -auto-approve
   ```

### 🔹 2. Configuração do Databricks Bundle

Utilizamos o Databricks Asset Bundles para gerenciar os jobs e notebooks.

#### **Instalação e Configuração**

1. Instale o Databricks CLI:
   ```bash
   pip install databricks-cli
   ```
2. Autentique-se:
   ```bash
   databricks configure --host <URL_DO_WORKSPACE>
   ```
3. Configure o bundle no Databricks com:
   ```bash
   databricks bundle deploy
   ```
4. Para executar um job manualmente:
   ```bash
   databricks bundle run <nome_do_job>
   ```

Caso a extensão oficial do Databricks no VSCode seja utilizada, é necessário:

- Python 3.10+
- Foi usada a versão databricks-connect==13.3.2, mas aceita ≥ 13.0.
- Jupyter configurado para usar a venv ativa

Se não for utilizada a extensão, é possível configurar credenciais manualmente com `databricks configure` e definir workspace, cluster, org ID, porta e PAT Token.

## 📌 Geração do PAT Token no Databricks

1. Acesse o Databricks.
2. Navegue até `User Settings > Developer`.
3. Selecione `Access Tokens > Create New Token`.
4. Defina a validade e gere o token.
5. Copie e armazene o token com segurança.

## 📄 Explicação dos Notebooks

### **Extração de Dados**

- O `extraction_notebook.ipynb` extrai dados do banco de dados SQL Server via JDBC e armazena no Unity Catalog na camada RAW.
- Utiliza `pyspark` e `pandas` para processar os dados.

### **Transformação de Dados**

- O `transformation_notebook.ipynb` consome os dados da RAW, aplica regras de limpeza e transformação para a camada STG.
- Cria tabelas organizadas, remove valores nulos e gera identificadores globais (GlobalID e UniqueID).
- Uma tabela consolidada (`one_big_table`) é criada com base em `SalesOrderHeader` e `SalesOrderDetail`.

## 📂 Estrutura de Diretórios

```
/
├── databricks_bundle/    # Configuração do Databricks Asset Bundles
├── src/                  # Códigos-fonte e notebooks
├── terraform/            # Arquivos do Terraform
├── .gitignore
├── README.md             # Este arquivo
├── requirements.txt      # Dependências do projeto
```

## 🛠 Dependências (requirements.txt)

O arquivo `requirements.txt` contém todas as dependências necessárias:

```txt
pyspark==3.5.0
pandas
SQLAlchemy==1.4.54
databricks-cli
databricks-connect==13.3.2
```

Para instalar, execute:

```bash
pip install -r requirements.txt
```

## 🔐 Configuração de Secrets no Databricks

Para armazenar credenciais de forma segura:

1. No Databricks, execute:
   ```bash
   databricks secrets create-scope --scope <nome_scope>
   ```
2. Adicione credenciais:
   ```bash
   databricks secrets put --scope <nome_scope> --key <nome_chave>
   ```
3. No notebook, recupere as credenciais:
   ```python
   dbutils.secrets.get(scope="<nome_scope>", key="<nome_chave>")
   ```

## 🚀 Considerações Finais

- Os acessos aos catálogos e schemas podem ser gerenciados diretamente no Databricks via `Data Explorer`.
- Os jobs podem ser configurados para rodar em diferentes horários e com diferentes triggers.
- A infraestrutura do Terraform e o Databricks Bundle estão organizados separadamente para manter a modularidade.

Obrigado pela atenção! 🎯