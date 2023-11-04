[![Terraform Registry](https://img.shields.io/badge/Terraform%20Registry-available-blue.svg)](https://registry.terraform.io/modules/seu-nome-de-usuario/seu-modulo)
[![AWS](https://img.shields.io/badge/AWS-supported-orange.svg)](https://aws.amazon.com/)
[![Amazon DocumentDB](https://img.shields.io/badge/Amazon%20DocumentDB-supported-brightgreen.svg)](https://aws.amazon.com/documentdb/)




# Tech Challenge - Fase 03 (GRUPO 31) - AWS Infraestrutura DocumentDB

Este repositório o terraform para criação dos seguintes itens:

* 2 subnets públicas dentro de uma VPC
* 1 security group para liberar a porta 27017 para as subnets privadas que são utilizadas pelo eks
* 1 cluster document db + instance 

## Motivo pela escolha do **MongoDB / Amazon DocumentDB**

A escolha do **MongoDB** se baseia na sua natureza altamente flexível e escalável. Como um banco de dados NoSQL orientado a documentos, o MongoDB nos proporciona a capacidade de lidar com dados variáveis e complexos sem a necessidade de um esquema predefinido, oferecendo uma solução dinâmica para as necessidades em constante mudança do nosso projeto. Além disso, sua arquitetura distribuída e capacidade de replicação nos permitem escalar horizontalmente à medida que nossos dados e demanda crescem, garantindo a disponibilidade e o desempenho contínuos. Essa escolha nos dá a liberdade de focar na inovação e na evolução do nosso aplicativo, sabendo que estamos apoiados por uma plataforma de gerenciamento de dados versátil e confiável.

Para uma boa jornada na AWS, a escolha do **Amazon DocumentDB**, um serviço de banco de dados totalmente gerenciado e compatível com **MongoDB** na AWS, foi motivada pela necessidade de uma solução robusta e escalável para gerenciamento de dados em nosso projeto.

Ao optar pelo **Amazon DocumentDB**, pudemos aproveitar a familiaridade e flexibilidade do modelo de dados baseado em documentos oferecido pelo MongoDB, ao mesmo tempo em que desfrutamos dos benefícios da infraestrutura escalável e confiável da AWS.

A alta disponibilidade proporcionada pelo **Amazon DocumentDB**, combinada com sua replicação automática e recuperação de falhas, garante que nossos dados permaneçam acessíveis e consistentes, mesmo em cenários de alta demanda ou em caso de falhas inesperadas.

Além disso, a capacidade de escalar verticalmente e horizontalmente conforme a demanda do aplicativo nos dá a flexibilidade de acompanhar o crescimento dos dados e do tráfego, sem comprometer a performance ou a disponibilidade.

Em resumo, a escolha do **Amazon DocumentDB** se mostrou uma decisão estratégica, proporcionando um ambiente de gerenciamento de dados confiável, escalável e altamente disponível. Isso nos permitiu focar em desenvolver e melhorar nossa aplicação, sabendo que estamos suportados por uma infraestrutura robusta e de alto desempenho.

# DER

![Alt text](Fiap-DB-3.png)

# Embedded document

customers

```
{
  "_id": { "$oid": "6546bb87ab5c9163ff5ef7d2" },
  "name": "Teste222222",
  "mail": "",
  "cpf": { "$numberDouble": "33811205811.0" },
  "subscription": "xx",
  "birthdate": {
    "$date": { "$numberLong": "512956800000" }
  },
  "created_at": {
    "$date": { "$numberLong": "1692471223402" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1692558797596" }
  }
}
```

products

```
{
  "_id": { "$oid": "6546bbebab5c9163ff5ef7d3" },
  "name": "Teste1",
  "price": { "$numberInt": "10" },
  "category": "ACCOMPANIMENT",
  "description": "xxx",
  "created_at": {
    "$date": { "$numberLong": "1692394868914" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1692394868914" }
  }
}
```

productsImages

```
{
  "_id": { "$oid": "6546bc22ab5c9163ff5ef7d4" },
  "productId": {
    "$oid": "6546bbebab5c9163ff5ef7d3"
  },
  "name": "Principal",
  "size": { "$numberInt": "10" },
  "type": "SNACK",
  "base64": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwkHBgoJCA.....L1ejMzMzMzMzMzMzMzMzMzM9WZn/d/9k=",
  "created_at": {
    "$date": { "$numberLong": "1693440821569" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1693440821569" }
  }
}
```

orders

```
{
  "_id": { "$oid": "6546bc46ab5c9163ff5ef7d5" },,
  "protocol": { "$numberInt": "20" }
  "customerId": {
    "$oid": "64e262c9c949fba1be313182"
  },
  "quantity": { "$numberDouble": "23.8" },
  "amount": { "$numberInt": "6" },
  "status": "DONE",
  "payment": "WAITING",
  "created_at": {
    "$date": { "$numberLong": "1693081772457" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1693439626843" }
  }
}
```

ordersItems

```
{
  "_id": { "$oid": "6546bc64ab5c9163ff5ef7d6" },
  "orderId": {
    "$oid": "6546bc46ab5c9163ff5ef7d5"
  },
  "productId": {
    "$oid": "6546bbebab5c9163ff5ef7d3"
  },
  "price": { "$numberInt": "0" },
  "quantity": { "$numberInt": "4" },
  "obs": "xxx ",
  "created_at": {
    "$date": { "$numberLong": "1692835640899" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1692835640899" }
  }
}
```

payments

```
{
  "_id": { "$oid": "6546bc86ab5c9163ff5ef7d7" },
  "orderId": {
    "$oid": "6546bc46ab5c9163ff5ef7d5"
  },
  "broker": "mercadopago",
  "status": "WAITING",
  "description": "",
  "created_at": {
    "$date": { "$numberLong": "1693079805617" }
  },
  "updated_at": {
    "$date": { "$numberLong": "1693079805617" }
  }
}
```

## Requisitos

* [Terraform](https://www.terraform.io/) - Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services. Terraform codifies cloud APIs into declarative configuration files.
* [Amazon AWS Account](https://aws.amazon.com/it/console/) - Amazon AWS account with billing enabled
* [aws cli](https://aws.amazon.com/cli/) optional

## Antes de começar

Esta execução esta fora do nível gratuito da AWS, importante avaliar antes de executar

## AWS configuração

Com os requisitos já identificados, configure abaixo no secrets do github.

```
AWS_ACCESS_KEY = "xxxxxxxxxxxxxxxxx"
AWS_SECRET_KEY = "xxxxxxxxxxxxxxxxx"
```

## Uso

Com os requisitos já identificados, configure abaixo no secrets do github.

```
      - name: Checkout do repositório
        uses: actions/checkout@v2
    
      - name: Configurando a AWS Credentials Action para o GitHub Actions
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_KEY }}
          aws-region: us-east-1
      - name: Setup Terraform CLI
        uses: hashicorp/setup-terraform@v2.0.2

      - name: Terraform Init - Iniciando
        run: terraform init

      - name: Terraform Apply - Aplicando
        run: |
          export VPC_ID=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=Fiap_Pixels --query 'Vpcs[0].VpcId' --output text)
          echo $VPC_ID
          terraform apply -auto-approve -var "aws_access_key=${{ secrets.AWS_ACCESS_KEY }}" -var "aws_secret_key=${{ secrets.AWS_SECRET_KEY }}" -var "vpc_id=${VPC_ID}"

      - name: DocumentDB Endpoint
        id: docdb
        run: echo "::set-output name=endpoint::$(terraform output docdb_endpoint)"

      - name: DocumentDB Endpoint
        run: echo "DocumentDB Endpoint is ${{ steps.docdb.outputs.endpoint }}"
```

### Execução do projeto

Ao efetuar um push no repositório develop com sucesso, é necessário efetuar um pull request na branch master para que a execução do pipeline do workflow seja executado
