<?php

class Application_Form_Usuario extends Twitter_Form
{
    protected $exibir;
    protected $tipo;

    public function __construct($tipo=null, $options = null) {
        $this->tipo = $tipo;
        if ( strtoupper($tipo)=='EDIT' ){
            $this->exibir = null;
        }else if ( strtoupper($tipo) == 'SHOW' ){
            $this->exibir = true;
        }
        parent::__construct($options);
    }
    
    public function init()
    {
        $this->setMethod('post');
        $this->setAttrib("horizontal", true);
        $this->setAttrib("autocomplete", "off");

        /**
         * Criacao dos campos utilizados
         */
        
        $id_usuario = new Zend_Form_Element_Hidden('id_usuario');
        $nom_usuario = new Zend_Form_Element_Text('nom_usuario',array(
            'label' =>  'Nome do Usuario',
            'required'  =>  true,
            'filters'   =>  array('StringTrim'),
            'validators' => array(
                        array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Campo "Nome" nao pode ser nulo'
                                )
                        )),
            ),
            'disabled'=>$this->exibir
        ));
        $nom_usuario->setAttrib('size', 50);
        
        $num_matricola_ra = $this->createElement('text', 'num_matricola_ra');
        $num_matricola_ra->setLabel('RA || Num. Matricula')
                ->setRequired(true)
                ->setFilters(array('alnum'))
                ->setValidators(array(
                    array('notEmpty', true, array(
                        'messages' => array (
                            'isEmpty' =>    'Numero de RA ou Matricula nao pode ser nulo',
                            'notNum'
                            )
                        ))
                    ))
                ->setAttrib('disabled', $this->exibir);
        
        $num_cpf = $this->createElement('text', 'num_cpf');
        $num_cpf->setLabel('CPF')
                ->setRequired(true)
                ->setFilters(array('StringTrim'))
                ->setValidators(array(
                    array('notEmpty', true, array(
                        'messages' => array (
                            'isEmpty' =>    'Numero do CPF nao pode ser nulo'
                            )
                        ))
                    ))
                ->setAttrib('disabled', $this->exibir);
        
        
        
        $num_rg = $this->createElement('text', 'num_rg');
        $num_rg->setLabel('RG')
                ->setAttrib('size', 25)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir)
                ->setValidators(array(
                array('Digits', false, array(
                                'messages' => array(
                                    'notDigits' => "Deve conter apenas numeros",
                                    'digitsStringEmpty' => 'Campo "RG" nao pode ser nulo',
                            ))),
                        array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Campo "RG" nao pode ser nulo'
                                )
                        )),
                ));
                
        
        $email = $this->createElement('text', 'email');
        $email->setLabel('Email')
                ->setAttrib('size', 25)
                ->setAttrib('width', 500)
                ->addValidator('EmailAddress')
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $dt_nascimento = $this->createElement('text', 'dt_nascimento');
        $dt_nascimento->setLabel('Data de Nascimento')
                ->setAttrib('size', 25)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);

        $num_telefone = $this->createElement('text', 'num_telefone');
        $num_telefone->setLabel('Numero de Telefone')
                ->setAttrib('size', 30)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
                //->setDescription('Digite aqui seu e-mail');
        
        /**
         * ELEMENTOS NAO DESCRITOS NO DIAGRAMA DE CLASSES:
         * tel comercial, ramal
         */
        $num_telefone_comercial = $this->createElement('text', 'num_telefone_comercial');
        $num_telefone_comercial->setLabel('Numero de Telefone Comercial')
                ->setAttrib('size', 30)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $num_ramal = $this->createElement('text', 'num_ramal');
        $num_ramal->setLabel('Ramal')
                ->setAttrib('size', 10)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $num_celular = $this->createElement('text', 'num_celular');
        $num_celular->setLabel('Numero Celular')
                ->setAttrib('size', 30)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        $nom_mae = $this->createElement('text', 'nom_mae');
        $nom_mae->setLabel('Nome da Mae')
                ->setAttrib('size', 70)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $campus = new Zend_Form_Element_Select('campus');
        $campus->setLabel('Campus')
                ->addMultiOptions(array(1 => 'Memorial', 2 => 'Santo Amaro', 3 => 'Vergueiro', 4 => 'Vila Maria'))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $dt_expiracao = $this->createElement('text', 'dt_expiracao');
        $dt_expiracao->setLabel('Data de Expiracao')
                ->setAttrib('size', 25)
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $senha = new Zend_Form_Element_Password('desc_senha');
        $senha->setLabel('Senha')
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $tipo_usuario = new Zend_Form_Element_Select('tipo_usuario');
        $tipo_usuario->setLabel('Tipo de Usuario:')
                ->addMultiOptions(array(1 => 'Aluno', 2 => 'Professor', 3 => 'Funcionario'))
                ->setRequired(true)
                ->setAttrib('disabled', $this->exibir);
        
        $flg_status = new Zend_Form_Element_Select('flg_status');
        $flg_status->setLabel('Status do Usuario:')
                ->setRequired(true)
                ->addMultiOptions(array(0 => 'Inativo',1 => 'Ativo'))
                ->setAttrib('disabled', $this->exibir);
        
        /*Depende do caso de uso UC_001*/
        $papel = new Application_Model_DbTable_Papel();
        $listaPapeis = $papel->getListaPapel();
        $flg_papel = new Zend_Form_Element_Select('flg_papel');
        $flg_papel->setLabel('Papel do Usuario:')
                ->setRequired(true)
                ->addMultiOptions($listaPapeis)
                ->setAttrib('disabled', $this->exibir);
        
        
        /**
         * Botao Submit
         */
        
        $submit = $this->createElement('submit', 'enviar');
        $submit->setLabel('Enviar Cadastro')
                ->setIgnore(true);
                //->setAttrib('onclick', 'if (confirm("Deseja editar o cadastro?")) { document.form.submit(); } return false;');
        
        
        /**
         * Adicao dos elementos
         */
        
        $this->addElements( array (
                            $id_usuario,
                            $nom_usuario,
                            $num_matricola_ra,
                            $email,
                            $num_cpf,
                            $num_rg,
                            $dt_nascimento,
                            $num_telefone,
                            $num_telefone_comercial,
                            $num_ramal,
                            $num_celular,
                            $nom_mae,
                            $campus,
                            $dt_expiracao,
                            $senha,
                            $tipo_usuario,
                            $flg_status,
                            $flg_papel,
                            ));
        
        //$this->addDisplayGroup( array('nom_usuario','num_ra_matricula','email','num_cpf', 'num_rg','dt_nascimento','num_telefone'), 'dadosPessoais', array('legend'=>'Dados Pessoais'));
        
        //$dadosPessoais = $this->getDisplayGroup('dadosPessoais');
        //$dadosPessoais->setDecorators(array(
        //            'FormElements',
        //            'Fieldset',
                    //array('HtmlTag',array('tag'=>'div','style'=>'width:50%;;float:left;'))
        //));
        
        $this->addElement("button", "voltar", array(
			"class" => "btn-primary",
			"label" => "Voltar",
                        "onclick" => 'window.location =\''.$this->getView()->url(array('controller'=>'usuario','action'=>'index')).'\' '
		));
        
        if( $this->exibir == FALSE ){
            $this->addElement($submit);
        }
        
        $this->addElement("button", "imprimir", array(
			"class" => "btn-primary",
			"label" => "Imprimir",
                        "onclick" => 'window.print()'
		));
        
        
        
    }


}