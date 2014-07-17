using Gee;
using Random;

class GradeDataGenerator {
    private ArrayList<string> first_names;
    private ArrayList<string> last_names;
    private HashMap<string, string> grades;

    public GradeDataGenerator (string first_file, string last_file) {
        first_names = load_names(first_file);
        last_names = load_names(last_file);
        grades = new HashMap<string, string>();
    }
    
    public void print_grades(int reps) {
        for (int i = 0; i < reps; i++) {
            grades[random_name()] = random_grades();
        }
        foreach (var g in grades.entries) {
            stdout.printf("%s: %s\n", g.key, g.value);
        }
    }

    private ArrayList<string> load_names (string filename) {
        var file = File.new_for_path(filename);
        assert(file.query_exists());
        var retval = new ArrayList<string>();
        try {
            var stream = new DataInputStream(file.read());
            string line;
            while ((line = stream.read_line(null)) != null) {
                retval.add(line);
            }
        } catch (Error e) {
            error("%s", e.message);
        }
        return retval;
    }

    private string random_name() {
        var first = first_names[int_range(0, first_names.size - 1)];
        var last = last_names[int_range(0, last_names.size - 1)];
        var retval = "%s, %s".printf(last, first);
        return !grades.has_key(retval) ? retval : random_name();
    }

    private int random_grade() {
        // I know the spec said 0 to 100, but let's presume that
        // these kids aren't going to be stone cold retarded.
        return 30 + int_range(0, 70);
    }

    private string random_grades() {
        return "%d %d %d %d %d".printf(random_grade(), random_grade(),
         random_grade(), random_grade(), random_grade());
    }

    static void main(string[] args) {
        var gen = new GradeDataGenerator("first.txt", "last.txt");
        gen.print_grades(int.parse(args[1]));
    }
}
