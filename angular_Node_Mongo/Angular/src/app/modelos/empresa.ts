export class Empresa {

    constructor(
        public nombre: string,
        public cif: string,
        public direccion: string,
        public localidad: string,
        public provincia: string,
        public cp: number,
        public email: string,
        public tlfno: string,
        public password: string,
        public tipo: string
    ) {}

    /*
    private __nom: string;
    private __cif: string;
    private __dire: string;
    private __loca: string;
    private __prov: string;
    private __cp: number;
    private __email: string;
    private __tlfno: string;
    private __pass: string;
    private __tipo: string;

    get Nombre(): string { return this.__nom; }
    set Nombre(n: string) { this.__nom = n; }

    get Apellidos(): string { return this.__cif; }
    set Apellidos(a: string) { this.__cif = a; }

    get Direccion(): string { return this.__dire; }
    set Direccion(d: string) { this.__dire = d; }

    get Localidad(): string { return this.__loca; }
    set Localidad(l: string) { this.__loca = l; }

    get Provincia(): string { return this.__prov; }
    set Provincia(p: string) { this.__prov = p; }

    get CP(): number { return this.__cp; }
    set CP(c: number) {
        this.validarPropiedad('CP', c) ? this.__cp = c : this.__cp = 99999;
    }

    get Email(): string { return this.__email; }
    set Email(e: string) {
        this.validarPropiedad('email', e) ? this.__email = e : this.__email = 'default@email.org';
    }

    get Tlfno(): string { return this.__tlfno; }
    set Tlfno(t: string) {
        this.validarPropiedad('tlfno', t) ? this.__tlfno = t : this.__tlfno = '(+34)111 223344';
    }

    get Pass(): string { return this.__pass; }
    set Pass(t: string) {
        this.validarPropiedad('pass', t) ? this.__pass = t : this.__pass = '123456';
    }

    get Tipo(): string { return this.__tipo; }
    set Tipo(t: string) { this.__tipo = t; }

    private validarPropiedad(nombreProp: string, value: any): boolean {

        let patron: RegExp;
        switch (nombreProp) {
            case 'CP':
                patron = /^[0-9]{5}/;
                break;
            case 'email':
                patron = /^.+@.(com|es|org)$/;
                break;
            case 'tlfno':
                patron = /^\(\+[0-9]{2}\)[0-9]{3} ([0-9]{2})\1{3} $/;
                break;
            case 'pass':
                patron = /^([0-9A-Za-z]){6,15}$/;
                break;
        }
        return patron.test(value);
    }
    */
}

