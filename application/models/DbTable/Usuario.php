<?php

class Application_Model_DbTable_Usuario extends Zend_Db_Table_Abstract
{

    protected $_name = 'tb_usuario';
    protected $_primary = 'id_usuario';
    
    /*
(`id_usuario`,
`nom_usuario`,
`num_matricola_ra`,
`num_rg`,
`num_cpf`,
`dt_nasc`,
`nom_nome_mae`,
`desc_campus`,
`desc_email`,
`flg_status_usuario`,
`desc_senha`,
`id_usu_sist`,
`flg_tipo_usuario`,
`delega_poder`,
`dt_inclusao`,
`dt_validade_senha`,
`dt_alteracao`,
`tb_campus_id_campus`)
     */
    
    
    public function pesquisarUsuario($id = null, $where = null, $order = null, $limit = null){
        if( !is_null($id) ){
            $arr = $this->find($id)->toArray();
            return $arr[0];
        }else{
            $select = $this->select()->from($this)->order($order)->limit($limit);
            if(!is_null($where)){
                $select->where($where);
            }
            return $this->fetchAll($select)->toArray();
        }
    }
    
    public function incluirUsuario(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'nom_usuario'           =>  $request['nom_usuario'],
            'num_matricola_ra'      =>  $request['num_matricola_ra'],
            'num_rg'                =>  $request['num_rg'],
            'num_cpf'               =>  $request['num_cpf'],    
            'num_telefone'          =>  $request['num_telefone'],            
            'num_celular'           =>  $request['num_celular'],
            'dt_nascimento'         =>  $request['dt_nascimento'],
            'nom_mae'               =>  $request['nom_mae'],
            'desc_campus'           =>  $request['desc_campus'],
            'desc_email'            =>  $request['desc_email'],
            'flg_status_usuario'    =>  $request['flg_status_usuario'],
            'desc_senha'            =>  $request['desc_senha'],
            //'id_usu_sist'           =>  $request['id_usu_sist'],//usuario que alterou o cadastro (quem esta logado)
            'flg_tipo_usuario'      =>  $request['flg_tipo_usuario'],
            'delega_poder'          =>  $request['delega_poder'],
            'dt_inclusao'           =>  $request['dt_inclusao'],
            'dt_validade_senha'     =>  $request['dt_validade_senha'],
            'dt_alteracao'          =>  $date,
            'dt_validade_login'     =>  $request['dt_validade_login']
        );
        return $this->insert($dados);
    }
    
    public function alterarUsuario(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'nom_usuario'           =>  $request['nom_usuario'],
            'num_matricola_ra'      =>  $request['num_matricola_ra'],
            'num_rg'                =>  $request['num_rg'],
            'num_cpf'               =>  $request['num_cpf'],    
            'num_telefone'          =>  $request['num_telefone'],            
            'num_celular'           =>  $request['num_celular'],
            'dt_nascimento'         =>  $request['dt_nascimento'],
            'nom_mae'               =>  $request['nom_mae'],
            'desc_campus'           =>  $request['desc_campus'],
            'desc_email'            =>  $request['desc_email'],
            'flg_status_usuario'    =>  $request['flg_status_usuario'],
            'desc_senha'            =>  $request['desc_senha'],
            'id_usu_sist'           =>  $request['id_usu_sist'],
            'flg_tipo_usuario'      =>  $request['flg_tipo_usuario'],
            'delega_poder'          =>  $request['delega_poder'],
            'dt_inclusao'           =>  $request['dt_inclusao'],
            'dt_validade_senha'     =>  $request['dt_validade_senha'],
            'dt_alteracao'          =>  $date,
            'dt_validade_login'     =>  $request['dt_validade_login']
        );
        $where = $this->getAdapter()->quoteInto("id_usuario = ?", $request['id_usuario']);
        $this->update($dados, $where);
    }


}