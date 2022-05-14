class Humanoid {

  //Vector of location
  PVector v;

  //Primary stats
  protected int level; //max 127
  protected int strength;
  protected int stamina;
  protected int agility;
  protected int dexterity;
  protected int wisdom;
  protected int intelligence;
  protected int charisma;

  //Secondary stats
  protected int armorClass;
  protected int attackPower;
  protected int hitPoints;
  protected int manaPoints;
  protected int endurance;
  protected int [] resists; //Poison, Magic, Disease, Fire, Cold

  //Tertiary stat
  int damagePerSecond;

  Humanoid(PVector v, int level) {
    this.v = v;
    this.level = level;
  }
  
  void initialize(){}
}
